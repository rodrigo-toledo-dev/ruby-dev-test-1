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
          expect(directory_children.is_root?).to be_falsey 
        end

        it 'should have a parent directory' do
          expect(directory_children.parent).not_to be_nil
          expect(directory_children.path).to have(2).items
          expect(FileSystem.roots).to have(1).items
        end
      end
    end
  end
end
