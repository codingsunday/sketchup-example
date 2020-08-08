require 'sketchup'

module ExportCsv
  toolbar = UI::Toolbar.new('Export')

  command = UI::Command.new('Export') do
    path = UI.savepanel('Export file to CSV', __dir__, 'export.csv')

    if path != nil
      data = []

      Sketchup.active_model.definitions.each do |definition|
        data << {
          name: definition.name,
          count: definition.count_instances
        }
      end
      
      file = File.new(path, 'w')

      file.write("Name,Count\n")

      data.each do |line|
        file.write("#{line[:name]},#{line[:count]}\n")
      end

      file.close
    end
  end

  toolbar.add_item(command)

  toolbar.show
end