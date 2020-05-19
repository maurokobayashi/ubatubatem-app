Trestle.resource(:opening_hours) do
  build_instance do |attrs, params|
    if params[:profile_id]
      profile = Profile.find(params[:profile_id])
      attrs[:profile] = profile
      if profile.opening_hours.present?
        last = profile.opening_hours.last
        attrs[:day] = OpeningHour.days[last.day]+1 if last.day != "dom"
        attrs[:opens_at] = last.opens_at
        attrs[:closes_at] = last.closes_at
      end
    end
    OpeningHour.new(attrs)
  end

  menu do
    item :opening_hours, icon: "fa fa-clock", label: "Horários de funcionamento", group: "dados da conta"
  end

  table do
    column :id, link: true
    column :profile, link: true
    column :day, header: "Horário", sort: :day, class: "media-title-column" do |opening_hour|
      safe_join([
        content_tag(:strong, opening_hour.day_to_s),
        content_tag(:small, "#{'%02d'%opening_hour.opens_at.hour}h às #{'%02d'%opening_hour.closes_at.hour}h", class: "text-muted hidden-xs")
      ], "&nbsp;".html_safe)
    end
    actions
  end

  form do
    select :profile_id, Profile.all
    select :day, OpeningHour.days.keys.to_a
    row do
      col(sm: 6) { time_field :opens_at }
      col(sm: 6) { time_field :closes_at }
    end
  end

end
