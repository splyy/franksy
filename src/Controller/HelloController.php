<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class HelloController extends AbstractController
{
    #[Route('/', name: 'app_hello')]
    public function index(): Response
    {
        return $this->render('hello/index.html.twig', [
            'message' => 'Demo de votre projet Symfony 8.0 avec FrankenPHP !',
        ]);
    }

    #[Route('/hello/{name}', name: 'app_hello_name', requirements: ['name' => '[a-zA-Z]+'])]
    public function hello(string $name = 'World'): Response
    {
        return $this->render('hello/hello.html.twig', [
            'name' => $name,
        ]);
    }
}
