
#
# Helpers
#

# User Prelude

global <<< require \prelude-ls


# Define own helpers

log = -> console.log.apply console, &; &0

mix = Object.define-property


# Install to global namespace

global <<< { log, mix }


