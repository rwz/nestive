module Nestive

  # The Nestive LayoutHelper provides a handful of helper methods for use in your layouts and views.
  #
  # See the documentation for each individual method for detailed information, but at a high level,
  # your parent layouts define `area`s of content. You can define an area and optionally add content
  # to it at the same time using either a String, or a block:
  #
  #     # app/views/layouts/global.html.erb
  #     <html>
  #       <head>
  #         <title><%= area :title, "MySite.com" %></title>
  #       </head>
  #       <body>
  #         <div id="content">
  #           <%= area :content %>
  #         </div>
  #         <div id="sidebar">
  #           <%= area :sidebar do %>
  #             <h2>About MySite.com</h2>
  #             <p>...</p>
  #           <% end %>
  #         </div>
  #       </body>
  #     </html>
  #
  # Your child layouts (or views) inherit and modify the parent by wrapping in an `extends` block
  # helper. You can then either `append`, `prepend` or `replace` the content that has previously
  # been assigned to each area by parent layouts.
  #
  # The `append`, `prepend` or `replace` helpers are *similar* to Rails' own `content_for`, which
  # accepts content for the named area with either a String or with a block). They're different to
  # `content_for` because they're only used modify the content assigned to the area, not retrieve it:
  #
  #     # app/views/layouts/admin.html.erb
  #     <%= extends :global do %>
  #       <% prepend :title, "Admin :: " %>
  #       <% replace :sidebar do %>
  #         <h2>Quick Links</h2>
  #         <ul>
  #           <li>...</li>
  #         </ul>
  #       <% end %>
  #     <% end %>
  #
  #     # app/views/admin/posts/index.html.erb
  #     <%= extends :admin do %>
  #       <% prepend :title, "Posts ::" %>
  #       <% replace :content do %>
  #         Normal view stuff goes here.
  #       <% end %>
  #     <% end %>
  module LayoutHelper

    # Declares that the current layour (or view) is inheriting from and extending another layout.
    #
    # @param [String] layout
    #   The base name of the file in `layouts/` that you wish to extend (eg `application` for `layouts/application.html.erb`)
    #
    # @example Extending the `application` layout to create an `admin` layout
    #
    #     # app/views/layouts/admin.html.erb
    #     <%= extends :application do %>
    #       ...
    #     <% end %>
    #
    # @example Extending the `admin` layout in a view (you'll need to render the view with `layout: nil`)
    #
    #     # app/controllers/admin/posts_controller.rb
    #     class Admin::PostsController < ApplicationController
    #       # You can disable Rails' layout rendering for all actions
    #       layout nil
    #
    #       # Or disable Rails' layout rendering per-controller
    #       def index
    #         render layout: nil
    #       end
    #     end
    #
    #     # app/views/admin/posts/index.html.erb
    #     <%= extends :admin do %>
    #       ...
    #     <% end %>
    def extends(layout, &block)
      # Make sure it's a string
      layout = layout.to_s

      # If there's no directory component, presume a plain layout name
      layout = "layouts/#{layout}" unless layout.include?('/')

      # Capture the content to be placed inside the extended layout
      @view_flow.get(:layout).replace capture(&block).to_s

      render template: layout
    end

    # Defines an area of content in your layout that can be modified or replaced by child layouts
    # that extend it. You can optionally add content to an area using either a String, or a block.
    #
    # Areas are declared in a parent layout and modified by a child layout, but since Nestive
    # allows for multiple levels of inheritance, a child layout can also declare an area for it's
    # children to modify.
    #
    # @example Define an area without adding content to it:
    #     <%= area :sidebar %>
    #
    # @example Define an area and add a String of content to it:
    #     <%= area :sidebar, "Some content." %>
    #
    # @example Define an area and add content to it with a block:
    #     <%= area :sidebar do %>
    #       Some content.
    #     <% end %>
    #
    # @example Define an area in a child layout:
    #     <%= extends :global do %>
    #       <%= area :sidebar do %>
    #         Some content.
    #       <% end %>
    #     <% end %>
    #
    # @param [Symbol] name
    #   A unique name to identify this area of content.
    #
    # @param [String] content
    #   An optional String of content to add to the area as you declare it.
    def area(name, content=nil, &block)
      content = capture(&block) if block_given?
      append name, content
      render_area name
    end

    # Appends content to an area previously defined or modified in parent layout(s). You can provide
    # the content using either a String, or a block.
    #
    # @example Appending content with a String
    #     <% append :sidebar, "Some content." %>
    #
    # @example Appending content with a block:
    #     <% append :sidebar do %>
    #       Some content.
    #     <% end %>
    #
    # @param [Symbol] name
    #   A name to identify the area of content you wish to append to
    #
    # @param [String] content
    #   Optionally provide a String of content, instead of a block. A block will take precedence.
    def append(name, content=nil, &block)
      content = capture(&block) if block_given?
      add_instruction_to_area name, :push, content
    end

    # Prepends content to an area previously declared or modified in parent layout(s). You can
    # provide the content using either a String, or a block.
    #
    # @example Prepending content with a String
    #     <% prepend :sidebar, "Some content." %>
    #
    # @example Prepending content with a block:
    #     <% prepend :sidebar do %>
    #       Some content.
    #     <% end %>
    #
    # @param [Symbol] name
    #   A name to identify the area of content you wish to prepend to
    #
    # @param [String] content
    #   Optionally provide a String of content, instead of a block. A block will take precedence.
    def prepend(name, content=nil, &block)
      content = capture(&block) if block_given?
      add_instruction_to_area name, :unshift, content
    end

    # Replaces the content of an area previously declared or modified in parent layout(s). You can
    # provide the content using either a String, or a block.
    #
    # @example Replacing content with a String
    #     <% replace :sidebar, "New content." %>
    #
    # @example Replacing content with a block:
    #     <% replace :sidebar do %>
    #       New content.
    #     <% end %>
    #
    # @param [Symbol] name
    #   A name to identify the area of content you wish to replace
    #
    # @param [String] content
    #   Optionally provide a String of content, instead of a block. A block will take precedence.
    def replace(name, content=nil, &block)
      content = capture(&block) if block_given?
      add_instruction_to_area name, :replace, [content]
    end

    # Purge the content of an area previously declared or modified in parent layout(s).
    #
    # @example Purge content
    #     <% purge :sidebar %>
    #
    # @param names
    #   A list of area names to purge
    def purge(*names)
      names.each{ |name| replace(name, nil)}
    end

    private

    # We record the instructions (declaring, appending, prepending and replacing) for an area of
    # content into an array that we can later retrieve and replay. Instructions are stored in an
    # instance variable Hash `@_area_for`, with each key representing an area name, and each value
    # an Array of instructions. Each instruction is a two element array containing a instruction
    # method (eg `:push`, `:unshift`, `:replace`) and a value (content String).
    #
    #     @_area_for[:sidebar] # => [ [:push,"World"], [:unshift,"Hello"] ]
    #
    # Due to the way we extend layouts (render the parent layout after the child), the instructions
    # are captured in reverse order. `render_area` reversed them and plays them back at rendering
    # time.
    #
    # @example
    #   add_instruction_to_area(:sidebar, :push, "More content.")
    def add_instruction_to_area(name, instruction, value)
      @_area_for ||= {}
      @_area_for[name] ||= []
      @_area_for[name] << [instruction, value]
      nil
    end

    # Take the instructions we've gathered for the area and replay them one after the other on
    # an empty array. These instructions will push, unshift or replace items into our output array,
    # which we then join and mark as html_safe.
    #
    # These instructions are reversed and replayed when we render the block (rather than as they
    # happen) due to the way they are gathered by the layout extension process (in reverse).
    def render_area(name)
      [].tap do |output|
        @_area_for.fetch(name, []).reverse_each do |method_name, content|
          output.public_send method_name, content
        end
      end.join.html_safe
    end

  end
end
