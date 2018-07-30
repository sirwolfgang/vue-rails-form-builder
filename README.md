# Vue Rails Tag Helper
A custom Rails tag helper for Vue.js

## Synopsis
```erb
<%= vue_form_for @user, v: { data: { user: @user } } do |f| %>
  <%= f.text_field :name %>
  <%= tag 'markdown-editor', v: { model: form.vue_model(:description) } %>
<% end %>
```

```html
<form data-user="{...}" ...>
  ...
  <input v-model="user.name" type="text" name="user[name]" ... />
  <markdown-editor v-model="user.description" />
</form>
```

```javascript
new Vue({
  el: element,
  data: {
    user: JSON.parse(element.dataset.user)
  }
})
```

## Installation
Add the following line to `Gemfile`:

```ruby
gem 'vue-rails-tag-helper'
```

Run `bundle install` on the terminal.

## Usage
```erb
<%= vue_form_for User.new do |f| %>
  <%= f.text_field :name %>
  <%= f.submit "Create" %>
<% end %>
```

The above ERB template will be rendered into the following HTML fragment:

```html
<form class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post">
  <input name="utf8" type="hidden" value="&#x2713;" />
  <input type="hidden" name="authenticity_token" value="..." />
  <input v-model="user.name" type="text" name="user[name]" id="user_name" />
  <input type="submit" name="commit" value="Create" />
</form>
```

Note that the third `<input>` element has a `v-model` attriubte, which can be interpreted by Vue.js as the _directive_ to create two-way data bindings between form fields and component's data.

If you are using the [Webpacker](https://github.com/rails/webpacker), create `app/javascript/packs/new_user_form.js` with following code:

```javascript
import Vue from 'vue/dist/vue.esm'

document.addEventListener("DOMContentLoaded", () => {
  const NewUserForm = new Vue({
    el: "#new_user",
    data: {
      user: {
        name: ""
      }
    }
  })
})
```

Add this line to the ERB template:

```erb
<%= javascript_pack_tag "new_user_form" %>
```

Then, you can get the value of `user[name]` field by the `user.name`.

If you use Rails 5.1 or above, you can also use `vue_form_with`:

```erb
<%= vue_form_with model: User.new do |f| %>
  <%= f.text_field :name %>
  <%= f.submit "Create" %>
<% end %>
```

By default, this gem render v-model tag with object and attributes snake_case per rails. If you want to render the v-model tag with object and attributes with camelcase you simply set the configuration in the initializer to the vue_form_for or vue_form_with tag:

```ruby
# config/initializers/vue.rb

VueRailsTagHelper.configure do |config|
  config.camelize = false
end
```

```erb
<%= vue_form_with(model: GenericModel.new) do |f| %>
  <%= f.text_field :generic_field %>
  <%= f.submit "Create" %>
<% end %>
```

This will render:

```html
 <input type="text" name="generic_model[generic_field]" id="generic_model_generic_field" v-model="genericModel.genericField">
```

## Options

To `vue_form_for` and `vue_form_with` methods you can provide the same options as `form_for` and `form_with`.

There is a special option:

* `:vue_scope` - The prefix used to the input field names within the Vue component.

## Tag Helper
This adds the ability for any tag helpers to accept params with a `v` prefix. Which will then be used to prepend attributes much like `data`. In addition to allowing you to set different vue options, it also will apply your camelize setting to both `v-model` and `v-data` options. However, due to the way vue updates objects, `v-data` options are translated and merged with your `data` options.
```erb
<%= tag :div, v: { data: { value: 3 }, 'on:click': 'doThis', model: form.vue_model(:name) } %>
```
```html
<div v-on:click="doThis" data-value="3" v-model="user.name" />
```

## Data Initialization
As the official Vue.js document says:

> `v-model` will ignore the initial `value`, `checked` or `selected` attributes
> found on any form elements.
> (https://vuejs.org/v2/guide/forms.html)

Because of this, all form controls get reset after the Vue component is mounted.

However, you can use [vue-data-scooper](https://github.com/kuroda/vue-data-scooper) plugin in order to keep the original state of the form. This does only work if all the attributes your plan on using map directly to form elements. Otherwise you can use the can just load your object from the `data` attribute.

## License
The `vue-rails-tag-helper` is distributed under the MIT license. ([MIT-LICENSE](https://github.com/sirwolfgang/vue-rails-tag-helper/blob/master/LICENSE))

## Authors
Zane Wolfgang Pickett
Tsutomu Kuroda (t-kuroda@oiax.jp)
