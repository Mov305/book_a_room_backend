# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

room_seeds = [
    {
      description: "Spacious double room with a balcony.",
      num: 101,
      room_type: "Double",
      night_cost: 150.00,
      image: "https://example.com/images/room101.jpg",
      booked: false,
      booked_end: nil
    },
    {
      description: "Cozy single room with a city view.",
      num: 202,
      room_type: "Single",
      night_cost: 80.00,
      image: "https://example.com/images/room202.jpg",
      booked: false,
      booked_end: nil
    },
    {
      description: "Luxury suite with a private jacuzzi.",
      num: 305,
      room_type: "Suite",
      night_cost: 300.00,
      image: "https://example.com/images/room305.jpg",
      booked: true,
      booked_end: "2023-07-20"
    },
    {
      description: "Family room with bunk beds for kids.",
      num: 410,
      room_type: "Family",
      night_cost: 200.00,
      image: "https://example.com/images/room410.jpg",
      booked: false,
      booked_end: nil
    }
  ]


  room_seeds.each do |room| 
    Room.create(room)
  end