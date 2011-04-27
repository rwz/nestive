module Nestive
  module LayoutHelper

    def extends(name, &block)
      capture(&block)
      render(:file => "layouts/#{name}")
    end
    
    def block(name, &block)
      append(name, &block)
      render_block(name)
    end
    
    def append(name, content=nil, &block)
      content = capture(&block) if block_given?
      instruct_block(name, :push, content)
    end
    
    def prepend(name, content=nil, &block)
      content = capture(&block) if block_given?
      instruct_block(name, :unshift, content)
    end
    
    def replace(name, content=nil, &block)
      content = capture(&block) if block_given?
      instruct_block(name, :replace, [content])
    end
    
    private
    
    def instruct_block(name, instruction, value)
      @_block_for ||= {}
      @_block_for[name] ||= []
      @_block_for[name] << [instruction, value]
    end
    
    def render_block(name)
      output = []
      instructions_for_block(name).each do |i|
        output.send(i.first, i.last)
      end
      output.join.html_safe
    end
    
    def instructions_for_block(name)
      instructions = (@_block_for[name] || []).reverse
    end

  end
end