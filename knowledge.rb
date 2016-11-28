class Module
  def attribute(attr, &block)
    attr, value = attr.first if attr.is_a? Hash

    define_method attr do
      unless send "#{attr}?"
        if value
          instance_variable_set "@#{attr}", value
        elsif block
          instance_variable_set "@#{attr}", instance_eval(&block)
        end
      end
      instance_variable_get "@#{attr}"
    end

    define_method "#{attr}=" do |val|
      instance_variable_set "@#{attr}", val
    end

    define_method "#{attr}?" do
      !instance_variable_get("@#{attr}").nil?
    end
  end
end
