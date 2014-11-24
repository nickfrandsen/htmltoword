require 'action_controller'
unless defined? Mime::DOCX
  Mime::Type.register "application/vnd.openxmlformats-officedocument.wordprocessingml.document", :docx
end

ActionController::Renderers.add :docx do |filename, options|
  unless formats.include?(:docx) || Rails.version < '3.2'
    formats[0] = :docx
  end

  if options[:template] == action_name
    if filename =~ /^([^\/]+)\/(.+)$/
      options[:prefixes] ||= []
      options[:prefixes].unshift $1
      options[:template] = $2
    else
      options[:template] = filename
    end
  end

  # disposition / filename
  disposition   = options.delete(:disposition) || 'attachment'
  if file_name = options.delete(:filename)
    file_name += ".docx" unless file_name =~ /\.docx$/
  else
    file_name = "#{filename.gsub(/^.*\//,'')}.docx"
  end

  # other properties
  word_template = options.delete(:word_template) || nil
  # content will come from property content unless not specified
  # then it will look for a template.
  content = options.delete(:content) || render_to_string(options)

  doc = Htmltoword::Document.create content, file_name, word_template
  send_data File.read(doc.path), :filename => file_name, :type => Mime::DOCX, :disposition => disposition
end

# For respond_with default
begin
  ActionController::Responder
rescue LoadError
else
  class ActionController::Responder
    def to_docx
      if @default_response
        @default_response.call(options)
      else
        controller.render({:docx => controller.action_name}.merge(options))
      end
    end
  end
end
