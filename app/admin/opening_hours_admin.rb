Trestle.resource(:opening_hours) do
  menu do
    group :catálogo do
      item :opening_hours, icon: "fa fa-clock", label: "Horários de funcionamento"
    end
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
