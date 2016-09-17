class UserMailer < ApplicationMailer
  def confirm_email(user)
    @user = user
    mail(to: "#{user.name} <#{user.email}>",
         subject: '[유니스트 커뮤니티] 포탈 메일 주소를 인증해주세요.')
  end
end
