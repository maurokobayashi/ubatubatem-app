Trestle.resource(:lead_excels) do
  menu do
    item :lead_excels, icon: "fa fa-file-excel", label: "Leads Excel", group: "leads"
  end

  search do |query|
    query ? LeadExcel.where("instagram ILIKE ? OR name ILIKE ?", "%#{query}%", "%#{query}%") : LeadExcel.all
  end

end
