namespace :assets do
  desc "Copy Font Awesome webfonts"
  task :copy_fonts do
    source = Rails.root.join("node_modules/@fortawesome/fontawesome-free/webfonts")
    target = Rails.root.join("public/webfonts")

    FileUtils.mkdir_p(target)
    FileUtils.cp_r("#{source}/.", target)
    puts "Font Awesome fonts copied to public/webfonts"
  end
end

# Run before assets:precompile
Rake::Task["assets:precompile"].enhance(["assets:copy_fonts"])
