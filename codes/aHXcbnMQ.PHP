<?php

namespace Swivl\UserBundle\Validator\Constraints;

use Symfony\Component\Validator\Constraint;

/**
 * Class BlackList
 *
 * @package Swivl\UserBundle\Validator\Constraints
 */
class BlackList extends Constraint
{
    /**
     * @var string
     */
    public $message = 'Something went wrong';

    /**
     * Validate class
     *
     * @return string
     */
    public function validatedBy()
    {
        return get_class($this) . 'Validator';
    }
}