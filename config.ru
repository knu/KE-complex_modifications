require 'shellwords'

DOCS_DIR = File.expand_path('docs', __dir__)

map '/' do
  use Rack::Static,
    urls: [''],
    root: DOCS_DIR,
    index: 'index.html'

  run proc {}
end

map '/dist.json' do
  run proc {
    [
      200,
      { 'Content-Type' => 'application/json' },
      [
        IO.popen("cd #{DOCS_DIR.shellescape} && ruby #{File.expand_path('scripts/make-distjs.rb', __dir__).shellescape}", &:read)
      ]
    ]
  }
end
