Rentals.RentalsRoute = Ember.Route.extend {
  setupController: (controller) ->
      controller.set('rentals', Rentals.Rental.find())
}
