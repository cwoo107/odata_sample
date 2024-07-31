# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "turbo_power" # @0.6.2
pin "@stimulus-components/reveal", to: "@stimulus-components--reveal.js" # @5.0.0
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@stimulus-components/password-visibility", to: "@stimulus-components--password-visibility.js" # @3.0.0
pin "@stimulus-components/clipboard", to: "@stimulus-components--clipboard.js" # @5.0.0
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@8.0.0-beta.2/dist/turbo.es2017-esm.js"
pin "tailwindcss-stimulus-components" # @5.1.1
