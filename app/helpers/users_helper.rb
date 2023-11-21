# frozen_string_literal: true

module UsersHelper
  def current_user_name(user)
    [user.name, user.email].find(&:present?)
  end

  def create_mentions
    contents = @report.content.scan(%r{http://localhost:3000/reports/(\d{1,})})
    return if contents.empty?

    contents.each do |content|
      Mention.create(mentioned_report_id: @report.id, mentioning_report_id: content[0])
    end
  end
end
