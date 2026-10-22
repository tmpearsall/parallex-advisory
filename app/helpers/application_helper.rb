module ApplicationHelper
  # Reading time, Medium's way: 265 words a minute plus a few seconds per image (12s for the first,
  # one less for each after, never under 3s), rounded up to whole minutes, minimum 1. The Sources
  # list is left out because readers skim it. Same formula on every Osparna/Parallex site.
  def reading_minutes(body)
    main = body.to_s.split(/<h2[^>]*>\s*Sources\s*<\/h2>/i).first.to_s
    images = main.scan(/<img\b/i).size
    words = main.gsub(/<[^>]+>/, " ").gsub(/&[a-z#0-9]+;/i, " ").scan(/\S+/).size
    secs = words * 60.0 / 265
    images.times { |i| secs += [12 - i, 3].max }
    [(secs / 60.0).ceil, 1].max
  end

  # "10 min read" for a Post record or a REST hash; nil when the body was not loaded (e.g. a
  # query that selects fewer columns), so a list never shows a wrong "1 min read".
  def reading_time_for(post)
    body = if post.respond_to?(:has_attribute?)
      post.has_attribute?(:body) ? post.body : nil
    elsif post.respond_to?(:[])
      post["body"]
    end
    body.present? ? "#{reading_minutes(body)} min read" : nil
  end
end
