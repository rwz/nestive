require 'spec_helper'

describe NestiveController do
  render_views

  context '#area' do
    it 'is empty by default' do
      get :index
      assert_select '#empty-area', ''
    end

    it 'shows initial value if any' do
      get :index
      assert_select 'title', 'Nestive'
    end

    it 'can accept blocks as initial value' do
      get :index
      assert_select '#some-area', 'Some content'
    end
  end

  context '#append' do
    it 'appends content to area as a string' do
      get :append
      assert_select 'title', 'Nestive is awesome'
    end

    it 'appends content to area as a block' do
      get :append
      assert_select '#some-area', "Some content\n  Another content"
    end
  end

  context '#prepend' do
    it 'prepends content to area as a string' do
      get :prepend
      assert_select 'title', 'Awesome Nestive'
    end

    it 'prepends content to area as a block' do
      get :prepend
      assert_select '#some-area', "Prepended\n        Some content"
    end
  end

  context '#replace' do
    it 'replaces area content with string' do
      get :replace
      assert_select 'title', 'Lolwut'
    end

    it 'replaces area content with block' do
      get :replace
      assert_select '#some-area', 'replaced'
    end
  end

  context '#purge' do
    it 'purge single area content' do
      get :purge_single
      assert_select 'title'
    end

    it 'purge few areas content' do
      get :purge_multiple
      assert_select 'title'
      assert_select '#some-area'
    end
  end

  context '#extends' do
    it 'extends layouts' do
      get :extended_one
      assert_select 'p', 'extended: one'
      assert_select 'title', 'extended: one'
      assert_select 'h2', 'extended: one'
    end

    it 'can extend already extended layouts' do
      get :extended_two
      assert_select 'p', 'extended: two'
      assert_select 'title', 'extended: one'
      assert_select '#some-area', 'extended: two'
      assert_select 'h2', 'extended: one'
    end

    it 'extends empty layout' do
      get :extended_three
    end
  end

  context '#locals' do
    it 'allows for options to be passed through to the file render' do
      get :locals
      assert_select 'title', 'Passed in as a local'
      assert_select '#some-area', 'locals: title'
    end
  end

  context '#extends_partial' do
    it 'nestive works great with partials also!' do
      get :extended_partial
      assert_select 'h1', 'Features'
      assert_select '#basic-features', 'Basic Features'
      assert_select '#extended-features', 'Extended Features'
    end
    it 'partials are a lot more fun with options' do
      get :extended_partial_options
      assert_select 'h1', 'Features'
      assert_select '#basic-feature-1', 'Basic Features 1'
      assert_select '#basic-feature-2', 'Basic Features 2'
      assert_select '#extended-features', 'Extended Features'
    end
  end
end
