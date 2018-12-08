

class DomainsController < ApplicationController
  def index
    @domains = Domain.all
  end

  def new
  end

  def create
    incoming_domains = params[:domain_list].strip.split(/\r?\n/)

    incoming_domains.each do |domain|
      new_domain = Domain.create(name: domain)
      new_domain.process_office365
    end
    redirect_to domains_path
  end

  def edit
  end

  def update

  end

  def destroy
    domain = Domain.find params[:id]
    domain.destroy
    redirect_to domains_path
  end
end
