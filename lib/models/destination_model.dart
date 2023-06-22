

import 'package:global/models/activity_model.dart';

class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({
    required this.imageUrl,
    required this.city,
    required this.country,
    required this.description,
    required this.activities,
  });
}

List<Activity> activities = [
  Activity(
    location: "Italy",
    name :"Venice",
    distance:50000,
    days:"14",
    price:1000,
    rating: 5,
    desc:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
  ),


];



List<Activity> activities2 = [
  Activity(
    location: "France",
    name :"Paris",
    distance:22500,
    price:1000,
    rating: 5,
    days:"7",
    desc:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
  ),
];

List<Activity> activities3 = [
  Activity(
    location: "India",
    name :"New Dehli",
    distance:45000,
    price:700,
    rating: 5,
    days:"22",
    desc:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
  ),
  ];
List<Activity> activities4=[
  Activity(
    location: "Brazil",
    name :"Sao Paulo",
    distance:47000,
    price:2000,
    days:"23",
    rating: 4,
    desc:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
  ),
];

List<Activity> activities5=[
  Activity(
    location: "Us",
    name :"New York",
    distance:57000,
    price:3000,
    rating: 5,
    days:"25",
    desc:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
  ),
];






List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/venice.jpg',
    city: 'Venice',
    country: 'Italy',
    description: 'Visit Venice for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/paris.jpg',
    city: 'Paris',
    country: 'France',
    description: 'Visit Paris for an amazing and unforgettable adventure.',
    activities: activities2,
  ),
  Destination(
    imageUrl: 'assets/newdelhi.jpg',
    city: 'New Delhi',
    country: 'India',
    description: 'Visit New Delhi for an amazing and unforgettable adventure.',
    activities: activities3,
  ),
  Destination(
    imageUrl: 'assets/saopaulo.jpg',
    city: 'Sao Paulo',
    country: 'Brazil',
    description: 'Visit Sao Paulo for an amazing and unforgettable adventure.',
    activities: activities4,
  ),
  Destination(
    imageUrl: 'assets/newyork.jpg',
    city: 'New York City',
    country: 'United States',
    description: 'Visit New York for an amazing and unforgettable adventure.',
    activities: activities5,
  ),
];
