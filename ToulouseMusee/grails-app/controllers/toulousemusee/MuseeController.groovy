package toulousemusee


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MuseeController {

    MuseeService museeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def doAddFavoris(){
        def museesfav = museeService.addFavoris(params.id)
        redirect (view: 'index', model: [museeInstanceList: museesfav, museeInstanceCount: museesfav.size()])
    }

    def doRemoveFavoris(){
        def museesSup = museeService.removeFavoris(params.id)
        render (view: 'index', model: [museeInstanceList: museesSup, museeInstanceCount: museesSup.size()])
        redirect (view: 'index', model: [museeInstanceList: museesSup, museeInstanceCount: museesSup.size()])
    }

    def doSearchMusees(){
        def museeList = museeService.searchMusees(params.nom,params.codepostal, params.nomrue)
        render (view: 'index', model: [museeInstanceList: museeList, museeInstanceCount: museeList.size()])
    }

//    def doSearchMuseesForAccueil(){
//        def museeList = museeService.searchMusees(params.nom,params.codepostal, params.nomrue)
//        render (view: 'index', model: [museeInstanceList: museeList, museeInstanceCount: museeList.size()])
//    }

    def index(Integer max) {
        params.max = Math.min(max ?: 5, 100)
        respond Musee.list(params), model: [museeInstanceCount: Musee.count()]
    }

    def show(Musee museeInstance) {
        respond museeInstance
    }

    def create() {
        respond new Musee(params)
    }

    @Transactional
    def save(Musee museeInstance) {
        if (museeInstance == null) {
            notFound()
            return
        }

        if (museeInstance.hasErrors()) {
            respond museeInstance.errors, view: 'create'
            return
        }

        museeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'musee.label', default: 'Musee'), museeInstance.id])
                redirect museeInstance
            }
            '*' { respond museeInstance, [status: CREATED] }
        }
    }

    def edit(Musee museeInstance) {
        respond museeInstance
    }

    @Transactional
    def update(Musee museeInstance) {
        if (museeInstance == null) {
            notFound()
            return
        }

        if (museeInstance.hasErrors()) {
            respond museeInstance.errors, view: 'edit'
            return
        }

        museeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Musee.label', default: 'Musee'), museeInstance.id])
                redirect museeInstance
            }
            '*' { respond museeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Musee museeInstance) {

        if (museeInstance == null) {
            notFound()
            return
        }

        museeInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Musee.label', default: 'Musee'), museeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'musee.label', default: 'Musee'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
