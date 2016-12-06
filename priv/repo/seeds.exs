alias GraphQl.{User,Post,Repo}

Repo.insert!(%User{name: "Sean Clayton", email: "sean@seanclayton.me"})
Repo.insert!(%User{name: "Bob Builder", email: "bob@canwefix.it"})

for _ <- 1..10 do
  Repo.insert!(%Post{
    title: Faker.Lorem.sentence,
    body: Faker.Lorem.paragraph,
    user_id: [1, 2] |> Enum.take_random(1) |> hd
  })
end
