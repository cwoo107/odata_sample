// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
import RevealController from '@stimulus-components/reveal'
import PasswordVisibility from '@stimulus-components/password-visibility'
import { Alert, Tabs, Popover, Modal } from "tailwindcss-stimulus-components"
application.register('alert', Alert)

application.register('popover', Popover)
application.register('tabs', Tabs)
application.register('modal', Modal)


application.register('reveal', RevealController)
application.register('password-visibility', PasswordVisibility)
