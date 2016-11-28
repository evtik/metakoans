class Module
  def attribute(attr, &block)
    attr, value = attr.first if attr.is_a? Hash

    class_eval("attr_accessor :#{attr}")

    define_method 'initialize' do
      send "#{attr}=", value if value
      send "#{attr}=", instance_eval(&block) if block
    end

    define_method("#{attr}?") do
      !(send attr).nil?
    end
  end
end
