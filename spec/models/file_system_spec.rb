require 'faker'
require 'rails_helper'

RSpec.describe FileSystem, type: :model do

  describe 'Validations of FileSystem' do
    let!(:file_system_invalid){ build(:file_system_invalid) }
    let!(:file_system){ build(:file_system) }

    describe 'validations' do
      subject { file_system_invalid }

      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to be_invalid }
      it 'should count of errors' do
        expect(subject.valid?).to be_falsey
        expect(subject.errors).to have(1).items
        expect(subject.errors.keys).to eql([:name])
      end
    end

    describe 'Directory operations' do
      subject { file_system }
      
      context 'FileSystem directory without root' do
        it 'should save root directory' do
          expect(subject.save).to be_truthy
        end
      end

      context 'FileSystem directory with root' do
        let(:directory_children) { create(:file_system, :with_parent) }

        it 'should be valid' do
          expect(directory_children).to be_valid
        end

        it 'should have parent equal' do
          expect(directory_children.parent).not_to be_nil
        end

        it 'should not be a root directory' do
          expect(directory_children.root?).to be_falsey 
        end

        it 'should have a parent directory' do
          expect(directory_children.parent).not_to be_nil
          expect(FileSystem.roots).to have(1).items
        end
      end
    end
  end

  describe 'FileSystem save operations' do
    let(:file_system){ build(:file_system) }
    context 'when is creating root directories' do
      it 'should not create directory without name' do
        file_system.name = ''
        expect(file_system.valid?).to be_falsey
        expect(file_system.errors).to have(1).items
      end

      it 'should create a diretory' do
        expect(file_system.save).to be_truthy
        expect(file_system.root?).to be_truthy 
      end
    end

    context 'when is creating children directories' do
      let!(:file_system){ create(:file_system) }
      it 'should create a children diretory' do
        children = file_system.children.build#(build(:file_system).attributes)
        children.name = 'middle-directory'
        expect(children.save).to be_truthy
        expect(children.root?).to be_falsey
      end
    end
  end

  describe 'saving files inside directory' do
    let(:file_system){ build(:file_system) }
    let!(:file) { fixture_file_upload(Rails.root.join('spec','support', 'fileone.txt')) }
    
    context 'save file into a directory' do
      it 'should create a directory with file(s)' do
        file_system_result = FileSystem.saveAndAttachFiles({name: file_system.name, files: file})
        expect(file_system_result).to be_truthy
        expect(file_system_result.files).to be_instance_of(ActiveStorage::Attached::Many)
        
      end
    end
  end

  describe "scenarios when have a parent" do
    let!(:file_system) { create(:file_system) }
    let(:file) { fixture_file_upload(Rails.root.join('spec','support', 'fileone.txt')) }

    context "save directory inside into some directory" do
      it "should save without files" do
        expect(FileSystem.saveAndAttachFiles({name: 'new children', parent_id: file_system.id})).to be_truthy
        file_system_children = FileSystem.where(id: file_system.child_ids).pluck(:name)
        expect(file_system_children).to eql(['new children']) 
      end
      
      it "should save with files" do
        expect(FileSystem.saveAndAttachFiles({name: 'new children', parent_id: file_system.id, files: file})).to be_truthy
        file_system_children = FileSystem.where(id: file_system.child_ids).pluck(:name)
        expect(file_system_children).to eql(['new children'])
      end
    end
    
  end
  
end
