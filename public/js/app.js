jQuery(document).ready(function() {
  window.app = (function() {
    var initialize,
      PetCollection,
      FormModel,
      FormView,
      formModel,
      petCollection;

    // ==== Model Definitions
    
    // Track state for the textbox
    FormModel = Backbone.Model.extend({});
    // Store  pet data
    PetModel = Backbone.Model.extend({});

    // ==== End Model Definitions

    // ==== Collection Definitions

    // Store the pet data collection
    PetCollection = Backbone.Collection.extend({
      model: PetModel,
      url: '/api/petfinder/pet_find',
      // PetFinder API is not the most thought-out
      // API ;)
      parse: function(resp) {
        var pets = resp.petfinder.pets.pet,
          that = this,
          results;

        results = _.map(pets, function(pet) {
          return that.formatData(pet);
        });
        return results;
      },
      // Transform PetFinder results
      // into something more meaningful
      formatData: function(data) {
        var temp = {
          "age": data.age['$t'],
          "animal": data.animal['$t'],
          "description": data.description['$t'],
          "name": data.name['$t'],
          "image": data.media.photos.photo[0]['$t']
        };
        //TODO: Add more information from the API
        return temp;
      }
    });

    // ==== End Collection Definitions

    // ==== View Definitions

    // Handle displaying the location form
    FormView = Backbone.View.extend({
      id: "location",
      template: Handlebars.compile($("#form-template").html()),
      events: {
        "click button": "handleSubmit",
        "change input": "setValue"
      },
      render: function() {
        var markup = this.template()
        this.$el.append(markup);
        return this;
      },
      handleSubmit: function(e) {
        petCollection.fetch({ data: formModel.toJSON(), reset: true });
      },
      setValue: function(e) {
        var value = e.target.value
        formModel.set({"location": value });
      }
    });

    // Handle displaying individual pet model records
    PetView = Backbone.View.extend({
      tagName: 'li',
      template: Handlebars.compile($("#pet-view-template").html()),
      render: function() {
        var markup = this.template(this.model.toJSON());
        this.$el.append(markup);
        return this;
      }
    });

    // Handle Viewing of the Pet Collection
    PetCollectionView = Backbone.View.extend({
      el: '#content',
      tagName: 'ul',
      initialize: function(options) {
        this.collection = options.collection;
        this.collection.on('sync', this.render, this);
      },
      render: function() {
        var $el = this.$el,
          petView;
        this.$el.empty();
        this.collection.forEach(function(model) {
          petView = new PetView({ model: model });
          $el.append(petView.render().el);
        });
        return this;
      }
    });

    // ==== End View Definitions

    // Main method for initializing the app
    // Pass the jQuery selector for the form container
    initialize = function($el) {
      var formView = new FormView(),
      petCollectionView;
      formModel = new FormModel();
      petCollection = new PetCollection();
      petCollectionView = new PetCollectionView({ collection: petCollection });
      $el.append(formView.render().el);
    };

    return {
      initialize: initialize
    };
  })();
});
