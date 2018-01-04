# This converter parses the entire document starting with each child node
# Formerly docbookRx began with the root node only and ignored
# doctypes and namespaces.
module SUSEShift
  def self.convert(str, opts = {})
    xmldoc = ::Nokogiri::XML::Document.parse str
    visit = DocbookVisit.new opts
    xmldoc.children.each do |node|
      node.accept visit
      visit.after
      visit.lines * "\n"
    end
  end