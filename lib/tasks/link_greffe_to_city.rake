
namespace :cities do
  desc 'link greffes to their cities'
  task link_to_greffes: :environment do
    Greffe.all.each do |greffe|
      city = greffe.find_or_create_city
      greffe.update_columns(city_id: city.id)
    end
  end
end

  # def create_progressbar(title, total)
  #   ProgressBar.create(format: '%t | %a %B %p%% | %r op/sec | %e', title: title, length: 120, total: total)
  # end
