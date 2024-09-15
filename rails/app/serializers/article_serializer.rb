class ArticleSerializer
  include Alba::Resource

  collection_key :article_list
  attributes :id, :title, :content

  attribute :created_at do |resource|
    resource.created_at.strftime("%Y/%m/%d")
  end

  attribute :from_today do |resource|
    now = Time.zone.now
    created_at = resource.created_at

    months = (now.year - created_at.year) * 12 + now.month - created_at.month - ((now.day >= created_at.day) ? 0 : 1)
    years = months.div(12)

    if years > 0
      "#{years}年前"
    elsif months > 0
      "#{months}ヵ月前"
    else
      seconds = (Time.zone.now - resource.created_at).round
      days = seconds / (60 * 60 * 24)
      if days.positive?
        "#{days}日前"
      else
        hours = seconds / (60 * 60)
        if hours.positive?
          "#{hours}時間前"
        else
          minutes = seconds / 60
          if minutes.positive?
            "#{minutes}分前"
          else
            "#{seconds}秒前"
          end
        end
      end
    end
  end

  attribute :user do |resource|
    UserSerializer.new(resource.user).as_json
  end
end
