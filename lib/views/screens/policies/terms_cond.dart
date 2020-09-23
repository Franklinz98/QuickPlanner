import 'package:app/backend/requets.dart';
import 'package:app/components/no_items.dart';
import 'package:app/components/no_projects.dart';
import 'package:app/components/model_description.dart';
import 'package:app/components/update_stock_dialog.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/phase.dart';
import 'package:app/models/project.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/models/stock_item.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsCond extends StatefulWidget {
  final Function onBackPressed;

  const TermsCond({
    Key key,
    @required this.onBackPressed,
  }) : super(key: key);

  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<TermsCond> with WidgetsBindingObserver {
  Brightness _brightnessValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    _brightnessValue ??= MediaQuery.of(context).platformBrightness;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "Términos y condiciones",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => widget.onBackPressed.call(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Text(
              """Al descargar o usar la aplicación, estos términos se aplicarán automáticamente a usted; por lo tanto, debe asegurarse de leerlos detenidamente antes de usar la aplicación. No se le permite copiar ni modificar la aplicación, ninguna parte de la aplicación o nuestras marcas comerciales de ninguna manera. No tiene permitido intentar extraer el código fuente de la aplicación y tampoco debe intentar traducir la aplicación a otros idiomas o hacer versiones derivadas. La aplicación en sí, y todas las marcas comerciales, derechos de autor, derechos de bases de datos y otros derechos de propiedad intelectual relacionados con ella, aún pertenecen a QuickPlanner.\n
QuickPlanner se compromete a garantizar que la aplicación sea lo más útil y eficiente posible. Por ese motivo, nos reservamos el derecho de realizar cambios en la aplicación o cobrar por sus servicios, en cualquier momento y por cualquier motivo. Nunca le cobraremos por la aplicación o sus servicios sin dejarle muy claro exactamente por qué está pagando.

La aplicación QuickPlanner almacena y procesa los datos personales que nos ha proporcionado para brindarle nuestro Servicio. Es su responsabilidad mantener su teléfono y el acceso a la aplicación seguros. Por lo tanto, le recomendamos que no haga jailbreak ni rootee su teléfono, que es el proceso de eliminar las restricciones y limitaciones de software impuestas por el sistema operativo oficial de su dispositivo. Podría hacer que su teléfono sea vulnerable a malware / virus / programas maliciosos, comprometer las funciones de seguridad de su teléfono y podría significar que la aplicación QuickPlanner no funcionará correctamente o no funcionará en absoluto.

La aplicación utiliza servicios de terceros que declaran sus propios términos y condiciones.

Enlace a los términos y condiciones de los proveedores de servicios externos utilizados por la aplicación

Servicios de Google Play
Google Analytics para Firebase

Debe tener en cuenta que hay ciertas cosas de las que QuickPlanner no se responsabiliza. Ciertas funciones de la aplicación requerirán que la aplicación tenga una conexión a Internet activa. La conexión puede ser Wi-Fi o provista por su proveedor de red móvil, pero QuickPlanner no puede asumir la responsabilidad de que la aplicación no funcione con todas sus funciones si no tiene acceso a Wi-Fi y no tiene ninguno de sus asignación de datos a la izquierda.

Si está utilizando la aplicación fuera de un área con Wi-Fi, debe recordar que los términos del acuerdo con su proveedor de red móvil se seguirán aplicando. Como resultado, su proveedor de telefonía móvil puede cobrarle el costo de los datos durante la duración de la conexión mientras accede a la aplicación, u otros cargos de terceros. Al usar la aplicación, acepta la responsabilidad de dichos cargos, incluidos los cargos de datos de roaming si usa la aplicación fuera de su territorio de origen (es decir, región o país) sin desactivar el roaming de datos. Si usted no es el pagador de facturas del dispositivo en el que está usando la aplicación, tenga en cuenta que asumimos que recibió el permiso del pagador de facturas para usar la aplicación.

En la misma línea, QuickPlanner no siempre puede asumir la responsabilidad de la forma en que usa la aplicación, es decir, debe asegurarse de que su dispositivo permanezca cargado; si se queda sin batería y no puede encenderlo para aprovechar el Servicio, QuickPlanner no puede aceptar la responsabilidad.

Con respecto a la responsabilidad de QuickPlanner por su uso de la aplicación, cuando esté usando la aplicación, es importante tener en cuenta que, aunque nos esforzamos por asegurarnos de que esté actualizado y sea correcto en todo momento, confiamos en terceros para proporcionar información para que podamos ponerla a su disposición. QuickPlanner no acepta ninguna responsabilidad por ninguna pérdida, directa o indirecta, que experimente como resultado de confiar completamente en esta funcionalidad de la aplicación.

En algún momento, es posible que deseemos actualizar la aplicación. La aplicación está disponible actualmente en Android; los requisitos del sistema (y para cualquier sistema adicional al que decidamos extender la disponibilidad de la aplicación) pueden cambiar, y deberá descargar las actualizaciones si desea seguir usando la aplicación. QuickPlanner no promete que siempre actualizará la aplicación para que sea relevante para usted y / o funcione con la versión de Android que ha instalado en su dispositivo. Sin embargo, usted se compromete a aceptar siempre las actualizaciones de la aplicación cuando se le ofrezcan. También es posible que deseemos dejar de proporcionar la aplicación y podemos cancelar su uso en cualquier momento sin notificarle la terminación. A menos que le indiquemos lo contrario, en caso de rescisión, (a) los derechos y licencias otorgados a usted en estos términos terminarán; (b) debe dejar de usar la aplicación y (si es necesario) eliminarla de su dispositivo.""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Cambios a esta política de privacidad",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Es posible que actualicemos nuestra Política de privacidad de vez en cuando. Por lo tanto, le recomendamos que revise esta página periódicamente para ver si hay cambios. Le notificaremos de cualquier cambio publicando la nueva Política de privacidad en esta página.\n
Esta política es efectiva a partir del 2020-09-23""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Contáctanos",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Si tiene alguna pregunta o sugerencia sobre nuestra Política de privacidad, no dude en contactarnos.\n
Esta página de política de privacidad fue creada en privacypolicytemplate.net y modificada / generada por App Privacy Policy Generator""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _brightnessValue = WidgetsBinding.instance.window.platformBrightness;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
