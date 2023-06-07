describe('Jungle app', () => {
  beforeEach("visit the main page", () => {
    cy.visit("http://localhost:3000/")
    cy.get(".form-control").first().type("tipsy@a.com")
    cy.get(".form-control").last().type("123456")
    cy.get(".btn-primary").click()

  })

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
})