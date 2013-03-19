module Datamappify
  module Data
    class Persistence
      def initialize(provider_class_name, entities, data_class_name)
        @provider_class_name = provider_class_name
        @entities            = entities
        @data_class_name     = data_class_name
      end

      def find(data_fields_mapping)
        raise Data::MethodNotImplemented
      end

      def create(data_fields_mapping)
        raise Data::MethodNotImplemented
      end

      def update(data_fields_mapping)
        raise Data::MethodNotImplemented
      end

      def destroy(id_or_entity)
        raise Data::MethodNotImplemented
      end

      def exists?(id)
        raise Data::MethodNotImplemented
      end

      def transaction(&block)
        raise Data::MethodNotImplemented
      end

      def method_missing(symbol, *args)
        data_class.send symbol, *args
      end

      private

      def data_class
        "Datamappify::Data::#{@provider_class_name}::#{@data_class_name}".constantize
      end

      def entity_class_name
        @entities[0].class.name
      end

      def is_entity_class?
        @data_class_name == entity_class_name
      end

      def key_field_name
        is_entity_class? ? :id : "#{entity_class_name.underscore}_id".to_sym
      end

      def extract_entity_id(id_or_entity)
        id_or_entity.is_a?(Integer) ? id_or_entity : id_or_entity.id
      end
    end
  end
end