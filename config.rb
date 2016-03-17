# Special config
require "lib/custom_helpers"
require "lib/general_helpers"
require "lib/site_config"
require 'lib/content_stuff'
helpers GeneralHelpers
config[:site_config] = SiteConfig.load_site_config("./site_config.yaml")



# General configuration

# Reload the browser automatically whenever files change


activate :directory_indexes
activate :pry
activate :syntax, :line_numbers => false
set :trailing_slash, true

set :js_dir, 'assets/javascripts'
set :css_dir, 'assets/stylesheets'
set :images_dir, 'assets/images'

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css
  # Minify Javascript on build
  activate :minify_javascript
end


configure :development do
  activate :livereload
end
###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/*.csv', layout: false

set :layout, :default_page_layout

THE_BOOK = []
config[:the_books] = THE_BOOK


# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }


data.recipes.each_pair do |book_slug, book_data|
# todo: make URL part of each recipe
    book_meta = book_data[:_meta]
    book_meta.recipes = []
    book_meta.chapters = []
    book_meta.slug = book_slug
    book_meta.url = "/books/#{book_slug}"
    THE_BOOK << book_meta

    book_chapters = book_data.reject{|(k, v)| k == '_meta'}

    book_chapters.each_pair do |chapter_slug, recipes|
      chapter_meta = recipes['_meta'] || Hashie::Mash.new({:title => chapter_slug}) # TK take this out
      chapter_meta[:recipes] = [] # OK to have double reference?
      chapter_meta.slug = "chapter-#{chapter_slug}"
      chapter_meta.url = "#{book_meta[:url]}##{chapter_meta[:slug]}"
      book_meta.chapters << chapter_meta

      # add the recipes
      recipes.reject{|(k,v)| k == '_meta'}.each_pair do |recipe_slug, recipe|
        the_url = "/books/#{book_slug}/#{recipe_slug}"
        recipe.url = the_url
        recipe.slug = recipe_slug
        recipe.book = book_meta
        recipe.chapter = chapter_meta
        recipe_content = Recipe.new(recipe)
        book_meta.recipes << recipe_content
        chapter_meta.recipes << recipe_content
        proxy(recipe.url,
              "/templates/recipe.html",
              :locals => {:dynamic_data_object => recipe_content,
                          :recipe => recipe_content},
              :ignore => true)
      end
    end

    proxy book_meta.url, '/templates/book.html',
      :locals => {:dynamic_data_object => book_meta, :book => book_meta},
      :ignore => true


end





activate :s3_sync do |s3_sync|
  s3_sync.delete                     = false
  s3_sync.after_build                = true
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404.html'
end
