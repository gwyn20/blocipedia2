class WikiPolicy < ApplicationPolicy

    class Scope
        attr_reader :user, :scope
     
        def initialize(user, scope)
            @user = user
            @scope = scope
        end
     
        def resolve
            wikis = []
            if user.nil?
                wikis = scope.all
            elsif user.role == 'premium'
                all_wikis = scope.all
                all_wikis.each do |wiki|
                    if !wiki.private || user = wiki.user || wiki.collaborators.include?(user)
                        wikis << wiki 
                    end
                end
            else 
                all_wikis = scope.all
                wikis = []
                all_wikis.each do |wiki|
                    if !wiki.private || wiki.collaborators.include?(user)
                        wikis << wiki 
                    end
                end
            end
            wikis 
        end
    end
end