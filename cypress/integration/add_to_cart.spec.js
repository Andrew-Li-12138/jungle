describe('Add to Cart', () => {
  beforeEach(() => {
    cy.visit('/') 
  })
  it('increases the cart count', () => {
    // Find and click the "Add to Cart" button for a product
    cy.get('.btn:contains("Add"):visible').first().click({ force: true });
    
    cy.get('.nav-item.end-0 .nav-link').contains('My Cart').click();

  })
})