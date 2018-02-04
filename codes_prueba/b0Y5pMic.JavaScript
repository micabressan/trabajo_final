'use strict';

module.exports = {
    name: 'show-on-select',
    view: {
        init: function($root) {
            this.$root = $root;

            $($root).on('click', this.onClick.bind(this));
        },

        onClick: function(e) {
            var $target = $(e.currentTarget);

            $target.addClass('hide');
        }
    }
};