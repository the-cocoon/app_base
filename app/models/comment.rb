#  MOVE TO APP VIEW?
class Comment < ActiveRecord::Base
  include ::TheCommentsBase::Comment
  include ::Notifications::LocalizedErrors

  def prepare_content
    self.title    = self.title.to_s.squish.strip
    self.contacts = self.contacts.to_s.squish.strip
    self.content  = process_content(self.raw_content, self.user)
  end

  def avatar_url

    user ? \
    user.avatar.url(:v100x100) : \
    ::User.new.avatar.url(:v100x100)

    # src    = id.to_s
    # src    = title unless title.blank?

    # _email = ::TheCommentsBase.normalize_email(contacts)
    # src    = _email if _email.match ::TheCommentsBase::EMAIL_REGEXP

    # hash = Digest::MD5.hexdigest(src)
    # "https://2.gravatar.com/avatar/#{ hash }?s=42&d=https://identicons.github.com/#{ hash }.png"
  end

  private

  def process_content txt, current_user
    txt = txt.to_s

    # Code Hightlight
    txt = ::ColoredCode.with_pygments(txt)

    ################################
    # Blocks in <noprocessing> tag will be Ignored
    ################################
    al_helper = ::AutoLink.new

    txt = ::ContentForProcessing.process(txt) do |str|
      # MarkDown
      res = ::Markdown2Tags.process(str)
      res = res.empty_p2br

      # AutoLink + Ext Link protection
      res = al_helper.auto_link(res, sanitize: false, html: { target: :_blank, rel: :nofollow })
      res = res.add_nofollow_to_links
      res = res.wrap_nofollow_links_with_noindex

      # Sanitize and Empty lines process
      res = sanitize_for(res, current_user)
    end

    ################################

    txt.strip
  end

  def sanitize_for txt, current_user
    if current_user.try :admin?
      Sanitize.fragment(txt, Sanitize::Config::ADMIN_RELAXED)
    else
      Sanitize.fragment(txt, Sanitize::Config::BLOGGER_HTML)
    end
  end
end