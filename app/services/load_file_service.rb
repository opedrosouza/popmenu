class LoadFileService < Actor
  input :file_path, type: String
  output :data, type: Hash

  def call
    self.data = JSON.parse(File.read(file_path)).with_indifferent_access
  end
end
