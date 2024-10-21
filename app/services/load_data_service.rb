class LoadDataService < Actor
  input :import, type: Import
  output :data, type: Hash

  def call
    self.data = import.json_read
  end
end
