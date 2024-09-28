# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'preline'
pin '@tailwindcss/forms', to: 'https://ga.jspm.io/npm:@tailwindcss/forms@0.5.7/src/index.js'
pin 'tailwindcss/plugin', to: 'https://ga.jspm.io/npm:tailwindcss@3.4.1/plugin.js'
