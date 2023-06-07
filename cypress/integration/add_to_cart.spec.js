describe('Jungle app', () => {
  beforeEach("visit the main page", () => {
    cy.visit("http://localhost:3000/")
    cy.get(".form-control").first().type("tipsy@a.com")
    cy.get(".form-control").last().type("123456")
    cy.get(".btn-primary").click()
  })
  it("There is 2 products on the page", () => {
    cy.get("nav").contains("My Cart (0)")
    
    cy.get("article")
      .first()
      .children("div")
      .children("form")
      .children("button")
      .click({force: true})
      
      cy.get("nav").contains("My Cart (1)")
  });

})