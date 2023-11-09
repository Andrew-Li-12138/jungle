describe('Product Detail Page', () => {
  beforeEach(() => {
    cy.visit('/') 
  })

  it('can navigates from home page to product details page', () => {
    cy.get('article:first-child a').click()
    cy.url().should('include', '/products/')
  })
})