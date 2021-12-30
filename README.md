# Tarea Postulación Desarrollador DevOps. Jr.

Este repositorio pretende presentarse como un extra a la tarea relacionada con la postulación a Desarrollador DevOps Jr de la Universidad de Chile.

* [Requerimientos](#requerimientos)
* [Instrucciones iniciales](#instrucciones-iniciales)
    * [1. Levantar Minikube](#1.-levantar-minikube)
    * [2. Variable de entorno](#2.-variable-de-entorno)
    * [3. Descargar dependencias](#3.-descargar-dependencias)
    * [4. Visualizar Acciones](#4.-visualizar-acciones)
    * [5. Levantar infraestructura](#5.-levantar-infraestructura)
* [Accediendo a la Aplicación](#accediendo-a-la-aplicacion)

## Requerimientos

Las aplicaciones que se requieren para levantar esta infraestructura localmente son:

- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

## Instrucciones iniciales 

Para levantar la infraestructura en Minikube debes seguir los siguientes pasos:

1. Levantar minikube
2. Definir variable de entorno con SECRET_KEY de la aplicación
3. Descargar las dependencias para levantar la infraestructura
4. Visualizar las acciones que se realizaran
5. Levantar la infrestructura

### 1. Levantar Minikube

Una vez tengamos instalado Minikube en nuestro equipo ejecutamos el siguiente comando para iniciarlo:

```
minikube start --driver=docker
```

### 2. Variable de entorno

Para crear la variable de entorno requerida, debemos definir una SECRET_KEY para la aplicación. Una vez lo tengamos ejecutamos el siguiente comando:

```
export SECRET_KEY="<random-string>"
```

### 3. Descargar dependencias

Para descargar las dependencias simplemente iniciamos terraform:

```
terraform init
```

### 4. Visualizar Acciones

Para visualizar las acciones que se ejecutarán en la nube, debemos ejecutar el siguiente comando:

```
terraform plan -var="secret_key='${SECRET_KEY}'"
```

### 5. Levantar infraestructura

Para levantar nuestra infraestructura debemos ejecutar el siguiente comando:

```
terraform apply -var="secret_key='${SECRET_KEY}'" -auto-approve
```

Si deseas destruir la infraestructura, debes ejecutar el siguiente comando:

```
terraform destroy -var="secret_key='${SECRET_KEY}'" -auto-approve
```

## Accediendo a la Aplicación

Para poder visualizar la aplicación, debemos relizar un port-fordward al pod que contiene la aplicación. Para esto debemos identificar al pod que se creo al realizar el deployment de la aplicación adjuntando el namespaces donde fueron creados.

```
kubectl -n python-project get all
```

Este comando nos mostrará el contenido del cluster dentro del namespace 'python-project'.

```
NAME                                  READY   STATUS    RESTARTS   AGE
pod/python-project-6c8fcb649c-t82lb   1/1     Running   0          77m

NAME                             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/python-project-service   NodePort   10.96.180.128   <none>        8000:31200/TCP   77m

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/python-project   1/1     1            1           77m

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/python-project-6c8fcb649c   1         1         1       77m
```

Una vez identificamos el pod, debemos realizar el pord-forward.

```
kubectl port-forward -n python-project pod/python-project-6c8fcb649c-t82lb 8000:8000 
```

Ahora podemos ingresar a la dirección http://localhost:8000 para visualizar la aplicación.
