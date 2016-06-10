using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Dominio;


namespace WindowsFormsApplication1
{
    public partial class Menu : Form
    {
        String username;
        String rol;
        Form[] formsFuncionalidades;

        public Menu(String username, String rol)
        {
            InitializeComponent();
            this.username = username;
            this.rol = rol;
            textBox1.Text = username;
            formsFuncionalidades = new Form[9];
            this.asignarVisibilidadYNombresABotones();
        }

        private void button0_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(0);
            formsFuncionalidades[0].Visible = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(1);
            formsFuncionalidades[1].Visible = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(2);
            formsFuncionalidades[2].Visible = true;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(3);
            formsFuncionalidades[3].Visible = true;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(4);
            formsFuncionalidades[4].Visible = true;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(5);
            formsFuncionalidades[5].Visible = true;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(6);
            formsFuncionalidades[6].Visible = true;
        }

        private void button7_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(7);
            formsFuncionalidades[7].Visible = true;
        }

        private void button8_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(8);
            formsFuncionalidades[8].Visible = true;
        }

        private void button9_Click(object sender, EventArgs e)
        {
            Cambio_de_Password.CambiarPassword cambiarPassword = new Cambio_de_Password.CambiarPassword(username);
            cambiarPassword.Show();
        }

        private void asignarFuncionalidadAlBoton(int nroBoton)
        {
            List<String> funcionalidades = Rol.getFuncionalidadesRol(rol);

            switch (funcionalidades[nroBoton])
            {
                case "Vender":
                    formsFuncionalidades[nroBoton] = new Generar_Publicación.PrincipalGenerarPublicacion(username);
                    break;

                case "Comprar/Ofertar":
                    formsFuncionalidades[nroBoton] = new ComprarOfertar.ListadoPublicaciones();
                    break;

                case "Historial de cliente":
                    formsFuncionalidades[nroBoton] = new Historial_Cliente.HistorialCliente();
                    break;

                case "Calificar al vendedor":
                    formsFuncionalidades[nroBoton] = new Calificar.Calificar();
                    break;

                case "Consulta de facturas":
                    formsFuncionalidades[nroBoton] = new Facturas.ListadoFacturas(username);
                    break;

                case "Listado estadístico":
                    formsFuncionalidades[nroBoton] = new Listado_Estadistico.ListadoEstadistico();
                    break;

                case "ABM Roles":
                    formsFuncionalidades[nroBoton] = new ABM_Rol.PrincipalRol();
                    break;

                case "ABM Usuarios":
                    formsFuncionalidades[nroBoton] = new ABM_Usuario.Principal();
                    break;

                case "ABM Visibilidades":
                    formsFuncionalidades[nroBoton] = new ABM_Visibilidad.PrincipalVisibilidad();
                    break;
            }
        }

        private void asignarVisibilidadYNombresABotones()
        {
            List<String> funcionalidades = Rol.getFuncionalidadesRol(rol);

            List<Button> botones = new List<Button>();
            botones.Add(button0);
            botones.Add(button1);
            botones.Add(button2);
            botones.Add(button3);
            botones.Add(button4);
            botones.Add(button5);
            botones.Add(button6);
            botones.Add(button7);
            botones.Add(button8);

            for (int i = 0; i < funcionalidades.Count(); i++)
            {
                botones[i].Text = funcionalidades[i];
                botones[i].Visible = true;
            }
        }

        private void mostrarMenuSegunRol(String username, String rol)
        {
            Form menu = new Menu(username, rol);
            menu.Visible = true;
        }

        //TODO: ver si esto es muy rancio
        protected override void OnFormClosing(FormClosingEventArgs e)
        {
            Application.Exit();
        }

        private void Menu_Load(object sender, EventArgs e)
        {

        }

    }
}
