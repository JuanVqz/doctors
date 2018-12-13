module HospitalsHelper
  def tags_spliter hospital
    return [] if hospital.tags.nil?
    hospital.tags.split(",")
  end
end
