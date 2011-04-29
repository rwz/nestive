# Nestive, A Nested Inheritable Layouts Plugin for Rails

**Note: This is ridiculously alpha proof-of-concept seeking feedback. Things will change.**

Nestive adds powerful layout and view helpers to your Rails app. It's similar to the nested layout technique [already documented in the Rails guides](http://guides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts) and found in many other nested layout plugins (a technique using `content_for` and rendering the parent layout at the end of the child layout). There's a bunch of problems with this technique, including:

* you can only *append* content to the content buffer with `content_for` (you can't prepend to content, you can't replace it)
* when combined with this nested layout technique, `content_for` actually *prepends* new content to the buffer, because each parent layout is rendered *after* it's child

Nestive is *better* because it addresses these problems.

## Just five methods (so far) – `block`, `extends`, `append`, `prepend`, `replace`.

### Defining a block of content in your parent layout with `block`:

The `block` helper is a lot like Rails' own `<%= yield :foo %>`, and is used in layouts to define and render a chunk of content in your layout:

    <%= area :sidebar %>
    
Unlike `yield`, `block` will allow your parent layouts to add content to the block at the same time using either a second argument or a block:

    <%= area :sidebar, "Some Content Here" %>

    <%= area :sidebar do %>
      Some Content Here
    <% end %>
    
It's important to note that this isn't *default* content, it *is* the content (unless a child changes it).

### Extending a layout in a child layout (or view):

Any layout (or view) can declare that it wants to inherit from and extend a parent layout, in this case we're extending `app/views/layouts/application.html.erb`:

    <%= extend :application do %>
       ...
    <% end %>
    
You can nest many levels deep:

    # app/views/posts/index.html.erb
    <%= extend :blog do %>
       ...
    <% end %>
    
    # app/views/layouts/blog.html.erb
    <%= extend :public do %>
       ...
    <% end %>
    
    # app/views/layouts/public.html.erb
    <%= extend :application do %>
       ...
    <% end %>

### Appending content to a block:

The implementation details are quite different, but the `append` helper works much like Rails' built-in `content_for`. It will work with either an argument or block, adding the new content onto the end of any content previously provided by parent layouts:

    <%= extend :application do %>
      <%= append :sidebar, "More content." %>
      <%= append :sidebar do %>
        More content.
      <% end %>
    <% end %>

### Prepending content to a block:

Exactly what you think it is. The reverse of `append` (duh), adding the new content at the start of any content previously provided by parent layouts:

    <%= extend :application do %>
      <%= prepend :sidebar, "Content." %>
      <%= prepend :sidebar do %>
        Content.
      <% end %>
    <% end %>

### Replacing content

You can also replace any content provided by parent layouts:

<%= extend :application do %>
  <%= replace :sidebar, "New content." %>
  <%= replace :sidebar do %>
    New content.
  <% end %>
<% end %>


## The token blog example

Set-up a global layout defining some content blocks. Note that there is no `<% yield %>` here.
    
    # app/views/layouts/application.html.erb
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <title><%= area :title %> JustinFrench.com</title>
      <meta name="description" content="<%= area :description, "This is my website." %>">
      <meta name="keywords" content="<%= area :keywords, "justin, french, ruby, design" %>">
    </head>
    <body>
      <div id="wrapper">
        <div id="content">
          <%= area :content do %>
            <p>Default content goes here.</p>
          <% end %>
        </div>
        <div id="sidebar">
          <%= area :sidebar do %>
            <h2>About Me</h2>
            <p>...</p>
          <% end %>
        </div>
      </div>
    </body>
    </html>
    
Next, we set-up a `blog` layout that extends `application`, replacing, appending & prepending content to the blocks we defined earlier.
    
    # app/views/layouts/blog.html.erb
    <%= extend :application do %>
      <% replace :title, "My Blog – " %>
      <% replace :description, "Justin French blogs here on Ruby, Rails, Design, Formtastic, etc" %>
      <% prepend :keywords, "blog, weblog, design links, ruby links, formtastic release notes, " %>
    <% end %>

Now our blog index view can extend `blog` and fill in the blocks with content specific to the index action.
    
    # app/views/posts/index.html.erb
    <%= extend :blog do %>
      <% replace :content do %>
        <h1>My Blog</h1>
        <% render @articles %>
      <% end %>
    
      <% append :content do %>
        <h2>Blog Roll</h2>
        <% render @links %>
      <% end %>
    <% end %>
    
We also need to instruct the `PostsController` not to wrap the view in a layout of it's own (default Rails behavior), which can be done on an individual action:

    # app/controllers/posts_controller.rb
    class PostsController < ApplicationController
      def index
        render :layout => nil
      end
    end

Or for an entire controller:

    # app/controllers/posts_controller.rb
    class PostsController < ApplicationController
      layout nil
    end
    
Or for every controller:

    # app/controllers/application_controller.rb
    class ApplicationController < ActionController::Base
      layout nil
    end

We'll find a way to make this easier or a bit more obvious in a future version.


## TODO

* Figure out how to test it
* Actually use it in an app
* You know, everything!


## Compatibility

Only testing it with Rails 3.1 (master), but it should work with Rails 2 & 3. We don't monkey patch or fiddle with any default behaviors in Rails. Use it when you want to, don't when you don't.

## You can help with...

* feedback
* reporting issues
* real-world use-cases
* ideas, forks, pull-requests
* performance testing