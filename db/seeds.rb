# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'admin@admin',
   password: 'ngadmin'
)

users = EndUser.create!(
  [
    {email: 'Aiu@test', name: 'Aiu', password: 'aiueok', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user1.jpg"), filename:"user1.jpg")},
    {email: 'Iue@test', name: 'Iue', password: 'kakiku', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user2.jpg"), filename:"user2.jpg")},
    {email: 'Uek@test', name: 'Okk', password: 'sasisu', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user3.jpg"), filename:"user3.jpg")}
  ]
)

Nail.create!(
  [
    {title: 'デサイン練習', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample1.jpg"), filename:"sample1.jpg"), body: '色々なデザインの練習をしました。', end_user_id: users[0].id },
    {title: 'お祝い', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample2.jpg"), filename:"sample2.jpg"), body: '赤に金ラメでお祝いムードに！友人ととあるお祝いをしました！！', end_user_id: users[1].id },
    {title: '2023年風', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample3.jpg"), filename:"sample3.jpg"), body: '卯年なので…。ぷっくりかわいい！', end_user_id: users[2].id }
  ]
)