<?php

/**
 * @file
 * Contains \Drupal\system\MachineNameController.
 */

namespace Drupal\system;

use Drupal\Component\Transliteration\TransliterationInterface;
use Drupal\Component\Utility\Unicode;
use Drupal\Core\Controller\ControllerInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Controller routines for machine name transliteration routes.
 */
class MachineNameController implements ControllerInterface {

  /**
   * The transliteration helper.
   *
   * @var \Drupal\Component\Transliteration\TransliterationInterface
   */
  protected $transliteration;

  /**
   * Constructs a MachineNameController object.
   *
   * @param \Drupal\Component\Transliteration\TransliterationInterface $transliteration
   *   The transliteration helper.
   */
  public function __construct(TransliterationInterface $transliteration) {
    $this->transliteration = $transliteration;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('transliteration')
    );
  }

  /**
   * Transliterates a string in given language. Various postprocessing possible.
   *
   * @param \Symfony\Component\HttpFoundation\Request $request
   *   The input string and language for the transliteration.
   *   Optionally may contain the replace_pattern, replace, lowercase parameters.
   *
   * @return \Symfony\Component\HttpFoundation\JsonResponse
   *   The transliterated string.
   */
  public function transliterate(Request $request) {
    $text = $request->query->get('text');
    $langcode = $request->query->get('langcode');
    $replace_pattern = $request->query->get('replace_pattern');
    $replace = $request->query->get('replace');
    $lowercase = $request->query->get('lowercase');

    $transliterated = $this->transliteration->transliterate($text, $langcode, '_');
    if($lowercase) {
      $transliterated = Unicode::strtolower($transliterated);
    }
    if(isset($replace_pattern) && isset($replace)) {
      $transliterated = preg_replace('@' . $replace_pattern . '@', $replace, $transliterated);
    }
    return new JsonResponse($transliterated);
  }

}
