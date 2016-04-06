  # Retorna o ultimo version que tem a situação auterada para suspenso
  def find_correct_version(record)
    record.versions.select do |version|
      version.object_changes.match(/\\nsituation:\\n-\s.*-\sSN\\n/)
    end.last
  end