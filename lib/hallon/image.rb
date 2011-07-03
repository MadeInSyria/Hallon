# coding: utf-8
module Hallon
  class Image
    extend Linkable

    link_converter(:image) do |link, session|
      Spotify::image_create_from_link(session.pointer, link)
    end

    # Create a new instance of an Image.
    #
    # @param [String, Link, FFI::Pointer] link
    # @param [Hallon::Session] session
    def initialize(link, session = Session.instance)
      @pointer = Spotify::Pointer.new convert(link, session), :image
    end

    # True if the image has been loaded.
    #
    # @return [Boolean]
    def loaded?
      Spotify::image_is_loaded(@pointer)
    end

    # Retrieve the current error status.
    #
    # @return [Symbol] error
    def status
      Spotify::image_error(@pointer)
    end

    # Retrieve image format.
    #
    # @return [Symbol] `:jpeg` or `:unknown`
    def format
      Spotify::image_format(@pointer)
    end

    # Retrieve image ID as a hexadecimal string.
    #
    # @return [String]
    def id
      Spotify::image_image_id(@pointer).read_string(20).unpack('H*')[0]
    end

    # Raw image data as a binary encoded string.
    #
    # @return [String]
    def data
      FFI::MemoryPointer.new(:size_t) do |size|
        data = Spotify::image_data(@pointer, size)
        return data.read_bytes(size.read_size_t)
      end
    end
  end
end