module CompaniesHelper
  def gravatar_url(company, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(company.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
